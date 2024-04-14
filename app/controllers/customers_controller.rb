class CustomersController < ApplicationController
  before_action :set_customer

  # GET /customers or /customers.json
  def index
    @customers = Customer.all
  end

  # GET /customers/1 or /customers/1.json
  def show
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers or /customers.json
  def create
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        format.html { redirect_to customer_url(@customer), notice: "Customer was successfully created." }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1 or /customers/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to customer_url(@customer), notice: "Customer was successfully updated." }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1 or /customers/1.json
  def destroy
    @customer.destroy!

    respond_to do |format|
      format.html { redirect_to customers_url, notice: "Customer was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def subscribe_to_plan
    if @customer.subscribe_to_plan("price_1P5BGRRuKjTLXSCQLv6PIlWU")
      redirect_to root_path, notice: 'Subscribed to plan successfully.'
    else
      redirect_to root_path, notice: 'Failed to subscribe.'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_customer
    if params[:id].nil?
      @customer = Customer.find(params[:customer_id])
    else
      @customer = Customer.find(params[:id])
    end
  rescue ActiveRecord::RecordNotFound
    Rails.logger.info "Record not found with id #{params[:id]}"
    # redirect_to root_path, alert: "Customer not found."
  end

  def customer_params
    # params.require(:customer).permit(:first_name, :last_name, :email, :phone)
    if params.has_key?(:customer_id)
    params.require(:customer_id).permit(:customer_id)
    else
    params.require(:customer).permit(:first_name, :last_name, :email, :phone)
    end

  end


end