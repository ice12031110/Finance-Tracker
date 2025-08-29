class PortfolioAssetsController < ApplicationController
  helper_method :category_select_options, :currency_select_options

  def index
    @resources = Asset.all
  end

  def new
    @resource = Asset.new
  end

  def create
    @resource = Asset.new(resource_params)
    
    if @resource.save
      redirect_to portfolio_assets_path, notice: t('.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def resource_params
    params.require(:asset).permit(:name, :category, :currency, :quantity, :ticker)
  end

  def category_select_options
    Asset.categories.keys.map do |key|
      [ t("asset.categories.#{key}", default: key.to_s.humanize), key ]
    end
  end

  def currency_select_options
    t("asset.currency")
  end
end
