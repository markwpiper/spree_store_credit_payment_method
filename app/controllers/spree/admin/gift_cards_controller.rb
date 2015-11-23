class Spree::Admin::GiftCardsController < Spree::Admin::BaseController
  load_and_authorize_resource :gift_card, :class => 'Spree::VirtualGiftCard'

  def index
    @gift_cards = @gift_cards.order('created_at DESC')

    if params[:gift_card].present? && params[:gift_card][:redemption_code].present?
      redemption_code = Spree::RedemptionCodeGenerator.format_redemption_code_for_lookup(params[:gift_card][:redemption_code])
      @gift_cards = @gift_cards.where(redemption_code: redemption_code)
    end
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @gift_card = Spree::VirtualGiftCard.new(resource_params)

    respond_to do |format|
      if @gift_card.save
        format.html { redirect_to [:admin,@gift_card], notice: 'Gift card was successfully created.' }
        format.json { render json: @gift_card, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @gift_card.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @gift_card.update(resource_params)
        format.html { redirect_to [:admin,@gift_card], notice: 'Gift card was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @gift_card.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @gift_card.destroy
    respond_to do |format|
      format.html { redirect_to admin_virtual_gift_cards_url }
      format.json { head :no_content }
    end
  end

  private

  def resource_params
    params.require(:virtual_gift_card).permit(:amount, :currency, :purchaser_id)
  end
end
