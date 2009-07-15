module ExampleHelpers
  def setup_example
    @example_text = "String"
  end
  
  def example_text
    @example_text
  end
end

World { |world| world.extend ExampleHelpers }
