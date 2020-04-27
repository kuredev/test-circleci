require "spec_helper"
require 'function1/person'

RSpec.describe Person do
  it "name is kure" do
    person = Person.new
    expect(person.name).to eq("kure")
  end

  it "name is kure(subject)" do
    expect(subject.name).to eq("kure")
  end
end
