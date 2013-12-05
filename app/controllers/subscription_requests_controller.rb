class SubscriptionRequestsController < ApplicationController
  # GET /subscription_requests
  # GET /subscription_requests.json
  def index
    @subscription_requests = SubscriptionRequest.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @subscription_requests }
    end
  end

  # GET /subscription_requests/1
  # GET /subscription_requests/1.json
  def show
    @subscription_request = SubscriptionRequest.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @subscription_request }
    end
  end

  # GET /subscription_requests/new
  # GET /subscription_requests/new.json
  def new
    @subscription_request = SubscriptionRequest.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @subscription_request }
    end
  end

  # GET /subscription_requests/1/edit
  def edit
    @subscription_request = SubscriptionRequest.find(params[:id])
  end

  # POST /subscription_requests
  # POST /subscription_requests.json
  def create
    @subscription_request = SubscriptionRequest.new(subscription_request_params)
    if @subscription_request.book.status == 1
      @subscription_request.errors.add(@subscription_request.book.title, " is rented")
    end
    book = Book.find(@subscription_request.book.id)
    book.status = 1
    @subscription_request.rental_date = Date.today

    respond_to do |format|
      if @subscription_request.book.status != 1 && @subscription_request.save && book.save
        format.html { redirect_to @subscription_request, notice: 'Subscription request was successfully created.' }
        format.json { render json: @subscription_request, status: :created, location: @subscription_request }
      else
        format.html { render action: "new" }
        format.json { render json: @subscription_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /subscription_requests/1
  # PUT /subscription_requests/1.json
  def update
    @subscription_request = SubscriptionRequest.find(params[:id])

    respond_to do |format|
      if @subscription_request.update_attributes(params[:subscription_request])
        format.html { redirect_to @subscription_request, notice: 'Subscription request was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @subscription_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subscription_requests/1
  # DELETE /subscription_requests/1.json
  def destroy
    @subscription_request = SubscriptionRequest.find(params[:id])
    @subscription_request.destroy

    respond_to do |format|
      format.html { redirect_to subscription_requests_url }
      format.json { head :ok }
    end
  end
  
  def new_from_book_list
    @subscription_request = SubscriptionRequest.new
    @book = Book.find(params[:book])
    @subscription_request.book = @book
    @subscription_request.user = User.current
        
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @subscription_request }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subscription_request
      @subscription_request = SubscriptionRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subscription_request_params
      params.require(:subscription_request).permit(:book_id, :user_id, :description, :created_at, :updated_at, :return_date, :rental_date)
    end
end
