Pod::Spec.new do |s|
  s.name         = "Hodor"
  s.version      = "1.6.7"
  s.summary      = "A short description of Hodor."

  s.description  = <<-DESC
                   A longer description of Hodor in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  s.homepage     = "https://github.com/jumperb/Hodor"

  s.license      = "Copyright"
  
  s.author       = { "jumperb" => "zhangchutian_05@163.com" }

  s.source       = { :git => "https://github.com/jumperb/Hodor.git", :tag => s.version.to_s}

  s.source_files = 'Classes/**/*.{h,m}'
  
  s.prefix_header_contents = '#import "HCommon.h"'
  
  s.libraries = 'z'
  s.framework = 'Accelerate'
  s.requires_arc = true
  
  s.ios.deployment_target = '6.0'

end
