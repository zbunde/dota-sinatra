require 'spec_helper'
require_relative '../../lib/user'
require 'sequel'


describe 'User Repository' do
  before do
    DB[:users].delete
    @usertable = User.new(DB)
  end

  it 'it can create a user' do
    id = @usertable.create(username: "test", first_name: "noob", last_name: "wtf", email: "email@email.com")
    expect(@usertable.index).to eq([{id: id, username: "test", first_name: "noob", last_name: "wtf", email: "email@email.com"}])
  end

  it 'can find individual users' do
    id = @usertable.create(username: "test", first_name: "noob", last_name: "wtf", email: "email@email.com")
    @usertable.create(username: "wtf", first_name: "wtf", last_name: "wtf", email: "wtf@wtf.com")
    expect(@usertable.find(id)).to eq(id: id, username: "test", first_name: "noob", last_name: "wtf", email: "email@email.com")
  end

  it 'can update a user in the database' do
    id = @usertable.create(username: "test", first_name: "noob", last_name: "wtf", email: "email@email.com")
    @usertable.update(id, username: "TESTTEST", first_name: "HELLO", last_name: "YOYO", email:"yea@yeah.com")
    expect(@usertable.find(id)).to eq(id: id, username: "TESTTEST", first_name: "HELLO", last_name: "YOYO", email:"yea@yeah.com")
  end

  it 'can delete users from database' do
    id = @usertable.create(username: "test", first_name: "noob", last_name: "wtf", email: "email@email.com")
    @usertable.delete(id)
    expect(@usertable.index).to eq([])
  end




end
