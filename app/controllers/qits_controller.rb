class QitsController < ApplicationController
  before_filter :authenticate
  def index
    @qits = Qit.paginate(:page => params[:page])
    if params[:search]
      @qits = Qit.all
      @qits = Qit.search(params[:search]).order("created_at DESC").paginate(:page => params[:page])
    end
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
      if @qit.item_status == "BORROWED"
        @qit.returned_on = nil
        @qit.save!
        redirect_to qits_path
      else
        @qit.borrower_id.upcase!
        @qit.borrower.upcase!
        @qit.item.upcase!
        @qit.item_id.upcase!
        @qit.item_status.upcase!
        @qit.incharge.upcase!
        @qit.issue.upcase!
        @qit.save!
        redirect_to qits_path
      end
    else
      render :edit
    end
  end

  def create
    @qit = Qit.new(qit_params)
    if @qit.save
      if @qit.item_status == "BORROWED"
        @qit.returned_on = nil
        @qit.borrower_id.upcase!
        @qit.borrower.upcase!
        @qit.item.upcase!
        @qit.item_id.upcase!
        @qit.item_status.upcase!
        @qit.incharge.upcase!
        @qit.issue.upcase!
        @qit.save!
        redirect_to root_path
      else
        @qit.borrower_id.upcase!
        @qit.borrower.upcase!
        @qit.item.upcase!
        @qit.item_id.upcase!
        @qit.item_status.upcase!
        @qit.incharge.upcase!
        @qit.issue.upcase!
        @qit.save!
        redirect_to root_path
      end
    else
      render "new"
    end
  end

  def destroy
    Qit.find( params[:id] ).destroy!
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
