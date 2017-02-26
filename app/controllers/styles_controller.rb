class StylesController < ApplicationController
  before_action :authenticate, only: [:destroy]
  def index
  end
end
