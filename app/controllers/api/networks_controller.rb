class Api::NetworksController < ApplicationController
  def index
    @networks = Network.all
    render "index.json.jb"
  end

  def show
    @network = Network.find_by(id: params[:id])
    render "show.json.jb"
  end
end
