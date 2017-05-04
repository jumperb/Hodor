Pod::Spec.new do |s|
  s.name         = "Hodor"
  s.version      = "2.0.1"
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

  s.requires_arc = true
  
  s.ios.deployment_target = '7.0'

  s.subspec 'Defines' do |ss|
      ss.ios.source_files = 'Classes/Defines/*.{h,m,mm,cpp,c}'
  end

  s.subspec 'Feature' do |ss|
      # ss.dependency 'Hodor'
      # ss.dependency 'AFNetworking' ,'~>2.0'
      # ss.dependency 'HCache'
      # ss.dependency 'HAccess/Entity'
      ss.ios.source_files = 'Classes/Features/**/*.{h,m,mm,cpp,c}'
  end


  s.subspec 'NS-Category' do |ss|
      ss.libraries = 'z'
      ss.ios.source_files = 'Classes/NS-Category/*.{h,m,mm,cpp,c}'
  end

  s.subspec 'UI-Category' do |ss|
      ss.framework = 'Accelerate'
      ss.ios.source_files = 'Classes/UI-Category/*.{h,m,mm,cpp,c}'
  end


  

end
