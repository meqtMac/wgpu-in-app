Pod::Spec.new do |spec|
    spec.name         = 'WgpuDemoCore'
    spec.version      = '0.0.1'
    spec.summary      = 'A brief description of WgpuDemoCore.'
    spec.description  = 'A longer description of WgpuDemoCore'
    spec.homepage     = 'https://github.com/yourusername/MyFramework'
    spec.license      = { :type => 'MIT', :file => 'LICENSE' }
    spec.author       = { 'meqtjiang' => 'meqtjiang@tencent.com' }
    spec.platform     = :ios, '12.0' # Adjust the platform version as needed
    spec.source       = { :path => '.' } # Use local path
    spec.vendored_frameworks = 'Frameworks/WgpuDemoCore.xcframework' # Path to your .xcframework
  end
