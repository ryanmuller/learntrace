class PagesController < ApplicationController
  def index
    @pins = Pin.order('updated_at DESC').limit(30)
  end

  def about
  end

  def feedback
  end

end
