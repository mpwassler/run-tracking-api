require 'rails_helper'

RSpec.describe Run, type: :model do

  it "saves run to database" do
    run = build(:run)
    expect(run).to be_valid
  end

  it "Will not save runs without a distance" do
    run = build(:run)
    run.distance = nil
    expect(run).to_not be_valid
  end

  it "Will not save runs without a duration" do
    run = build(:run)
    run.duration = nil
    expect(run).to_not be_valid
  end

  it "Will not save runs without a title" do
    run = build(:run)
    run.title = nil
    expect(run).to_not be_valid
  end

end
