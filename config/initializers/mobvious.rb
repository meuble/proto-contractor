Mobvious.configure do |config|
  config.strategies = [
    Mobvious::Strategies::URL.new(:mobile_path, disable_if_referer_set: true),
    Mobvious::Strategies::Cookie.new([:mobile, :tablet, :desktop]),
    Mobvious::Strategies::MobileESP.new(:mobile_tablet_desktop)
  ]
end