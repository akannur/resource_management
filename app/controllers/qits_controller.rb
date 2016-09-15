class QitsController < ApplicationController
  before_filter :authenticate
  def index
    @qits = Qit.page(params[:page]).per(12)
  end

  def new
    @qit = Qit.new
  end

  def edit
    @qit = Qit.find params[:id]
  end

  def create
    @qit = Qit.new(params.require(:qit).permit(:borrower, :item, :item_id, :borrowed_on, :returned_on, :item_status, :incharge, :issue))
    if @qit.save
      @qit.returned_on = nil
      @qit.save
      redirect_to root_path
    else
      render "new"
    end
  end

end
