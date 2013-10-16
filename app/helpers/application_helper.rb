# coding: utf-8

ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|   
  #include ActionView::Helpers::RawOutputHelper
  %(<span class="#{html_tag.match(/<label.*/) ? "error-label" : "error-field"}">#{html_tag}</span>).html_safe
end

module ApplicationHelper

  include Mobvious::Rails::Helper  
  
  def request_parameters
    controller.request_parameters
  end
  
  def render_flash_messages
    %Q(<p class="alert #{"danger" if alert}">#{notice || alert}</p>).html_safe if alert || notice
  end
  
  def mobile_viewport_meta_tags(icon)
    %Q(<link rel="apple-touch-icon-precomposed" href="#{asset_path(icon)}" />
    <link rel="apple-touch-icon" href="#{asset_path(icon)}" />  
    <link rel="apple-touch-startup-image" href="#{asset_path(icon)}" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
    <meta name="viewport" content = "width = device-width,initial-scale = 1,user-scalable = no" />).html_safe
  end
  
  def asset_url(image)
    "#{request.protocol}#{request.host_with_port}#{asset_path(image)}"
  end
  
  def error_messages_for(*objects)
    objects.inject([]) do |acc, object|
      if defined?(object) && object && object.errors.any?
        errors = object.errors.full_messages.inject([]) do |acc, msg|
          acc << content_tag(:li, msg)
        end
        content_tag(:ul, raw(errors.join("\n")), :class => "object-errors")
      end
    end.try :html_safe
  end
  
  def external_link_to(title, url, *args)
    options = args.extract_options!
    options.merge!(rel: :external)
    link_to(raw(title), url, options)
  end

  def pluralize(count, singular, plural, use_bold = false)
    count = 0 if count.nil?
    raw "#{(use_bold ? "<strong>#{count}</strong>" : count)} #{count > 1 ? plural : singular}"
  end
  
  def formatted_pluralize(count, singular, plural, use_bold = false)
    count ||= 0
    count_label = (use_bold ? "<strong>#{count}</strong>" : count)
    raw(count > 1 ? plural % count_label : singular % count_label)
  end
  
  def pluralize_without_number(count, singular, plural)
    "#{count > 1 ? plural : singular}"
  end

  def pluralize_with_none(count, none, singular, plural, use_bold = false)
    count ||= 0
    count.zero? ? none : pluralize(count, singular, plural, use_bold)
  end
  
end