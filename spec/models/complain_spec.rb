require 'rails_helper'

RSpec.describe Complain, type: :model do

  it 'valid with all fields' do
    complain = Complain.create(
      name: FFaker::Name,
      title: FFaker::Name.first_name,
      description: FFaker::Name,
      locale: FFaker::AddressBR.full_address,
      company: FFaker::Company.name
    )

    expect(complain).to be_valid
  end

  it 'valid without name' do
    complain = Complain.create(
      title: FFaker::Name.first_name,
      description: FFaker::Name,
      locale: FFaker::AddressBR.full_address,
      company: FFaker::Company.name
    )

    expect(complain).to be_valid
  end

  it 'invalid without title' do
    complain = Complain.create(
      description: FFaker::Name,
      locale: FFaker::AddressBR.full_address,
      company: FFaker::Company.name
    )

    expect(complain).to_not be_valid
  end

  it 'invalid without description' do
    complain = Complain.create(
      title: FFaker::Name.first_name,
      locale: FFaker::AddressBR.full_address,
      company: FFaker::Company.name
    )

    expect(complain).to_not be_valid
  end

  it 'invalid without locale' do
    complain = Complain.create(
      description: FFaker::Name,
      title: FFaker::Name.first_name,
      company: FFaker::Company.name
    )

    expect(complain).to_not be_valid
  end

  it 'invalid without company' do
    complain = Complain.create(
      description: FFaker::Name,
      title: FFaker::Name.first_name,
      locale: FFaker::AddressBR.full_address
    )

    expect(complain).to_not be_valid
  end

  it 'check coordinates presence after save' do
    complain = Complain.create(
                              name: FFaker::Name,
                              title: FFaker::Name.first_name,
                              description: FFaker::Name,
                              locale: FFaker::AddressBR.city,
                              company: FFaker::Company.name
                              )
    expect(complain.coordinates).to be_truthy
  end

  it 'check if coodinates array is valid' do
    complain = Complain.create(
                              name: FFaker::Name,
                              title: FFaker::Name.first_name,
                              description: FFaker::Name,
                              locale: FFaker::AddressBR.city,
                              company: FFaker::Company.name
                              )
    expect(complain.coordinates.length).to eq(2)
  end

end
