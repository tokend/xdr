require 'bundler'
Bundler.setup()
require 'pry'

namespace :xdr do

  task :update => [:generate]

  task :generate do
    require "pathname"
    require "xdrgen"
    require 'fileutils'
    FileUtils.rm_f("docs/build/tokend_openapi_generated.yaml")

    paths = Pathname.glob("./*.x").sort
    compilation = Xdrgen::Compilation.new(
      paths,
      output_dir: "docs/build",
      namespace:  "tokend",
      language:   :openapi
    )
    compilation.compile
  end
end
