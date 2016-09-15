class QitsController < ApplicationController
  def index
    @qits = Qit.page(params[:page]).per(2)
  end

  def new
    @qit = Qit.new
  end

  def edit
    @qit = Qit.find params[:id]
  end

  def create
    @qit = Qit.new(params.require(:qit).permit(:borrower, :item, :item_id, :borrowed_on, :item_status, :incharge))
    if @qit.save
      redirect_to root_path
    else
      render "new"
    end
  end

end
