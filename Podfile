# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'
use_frameworks!

### GROUPS

def target_pods
  # TODO
end

def format_pods
  # these contain executables, run on pre-commit
  pod 'SwiftLint'
  pod 'SwiftFormat/CLI'
end

def testing_pods
  pod 'Quick'
  pod 'Nimble'
end

### TARGETS

target 'TransformersBattle' do
  target_pods
  format_pods
end

target 'TransformersBattleTests' do
  target_pods
  testing_pods
end

target 'TransformersBattleLogicTests' do
  target_pods
  testing_pods
end
