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

  def update
    @qit = Qit.find(params[:id])
    if @qit.update_attributes(qit_params)
      redirect_to qits_path
    else
      render :edit
    end
  end

  def create
    @qit = Qit.new(params.require(:qit).permit(:borrower_id, :borrower, :item, :item_id, :borrowed_on, :item_status, :incharge, :issue))
    if @qit.save
      @qit.borrower_id.upcase!
      @qit.borrower.upcase!
      @qit.item.upcase!
      @qit.item_id.upcase!
      @qit.item_status.upcase!
      @qit.incharge.upcase!
      @qit.issue.upcase!
      @qit.save
      redirect_to root_path
    else
      render "new"
    end
  end

  def destroy
    @qit = Qit.find(params[:id])
    @qit.destroy

    redirect_to qits_path
  end

  private
    # Using a private method to encapsulate the permissible parameters is just a good pattern
    # since you'll be able to reuse the same permit list between create and update. Also, you
    # can specialize this method with per-user checking of permissible attributes.
    def qit_params
      params.require(:qit).permit(:borrower_id, :borrower, :item, :item_id, :borrowed_on, :returned_on, :item_status, :incharge, :issue)
    end

end
