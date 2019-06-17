require 'rails_helper'

RSpec.describe Complain, type: :model do

  it 'valid without name' do
    expect(Complain.create(
      title: 'titulo Teste',
      description: 'descrição',
      locale: 'são paulo, sp',
      company: 'empresa teste'
    )).to be_valid
  end

  it 'invalid without title' do
    expect(Complain.create(
      description: 'descrição',
      locale: 'são paulo, sp',
      company: 'empresa teste'
    )).to_not be_valid
  end

  it 'invalid without description' do
    expect(Complain.create(
      title: 'titulo Teste',
      locale: 'são paulo, sp',
      company: 'empresa teste'
    )).to_not be_valid
  end

  it 'invalid without locale' do
    expect(Complain.create(
      title: 'titulo Teste',
      description: 'descrição',
      company: 'empresa teste'
    )).to_not be_valid
  end

  it 'invalid without company' do
    expect(Complain.create(
      title: 'titulo Teste',
      description: 'descrição',
      locale: 'são paulo, sp'
    )).to_not be_valid
  end

  it 'check coordinates presence after save' do
    complain = Complain.create(
                              name: 'Nome teste',
                              title: 'titulo Teste',
                              description: 'descrição',
                              locale: 'são paulo, sp',
                              company: 'empresa teste'
                              )
    expect(complain.coordinates).to be_truthy
  end

  it 'check if coodinates array is valid' do
    complain = Complain.create(
                              name: 'Nome teste',
                              title: 'titulo Teste',
                              description: 'descrição',
                              locale: 'são paulo, sp',
                              company: 'empresa teste'
                              )
    expect(complain.coordinates.length).to eq(2)
  end

end
