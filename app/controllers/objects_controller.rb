class ObjectsController < ApplicationController
  def create
    obj = EncryptedObject.create! :data => params[:data]
    render :json => { 'id' => obj.id.to_s, 'data' => obj.data }
  end

  def show
    obj = EncryptedObject.find params[:id]
    render :json => { 'id' => obj.id.to_s, 'data' => obj.data }
  end
end
