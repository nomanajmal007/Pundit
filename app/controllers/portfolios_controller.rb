class PortfoliosController < ApplicationController

  def index
    @portfolio = policy_scope(Portfolio).all
    authorize @portfolio
  end

  
  def angular
    @angular = Portfolio.angular
  end


  def rubyonrails
      @rubyonrails=Portfolio.ruby_on_rails_portfolios
  end

  def new
    @portfolio=Portfolio.new
    3.times {@portfolio.technologies.build}
  end


  def create
      @portfolio = Portfolio.new(portfolio_params)

      respond_to do |format|
        if @portfolio.save
          current_user.add_role :creator, @portfolio
          format.html { redirect_to portfolios_path, notice: "Your Portfolio is Live Now." }
          format.json { render :show, status: :created, location: @portfolio }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @portfolio.errors, status: :unprocessable_entity }
        end
      end
  end

  def edit
      @portfolio=Portfolio.find(params[:id])
  end

  def update
      @portfolio=Portfolio.find(params[:id])
      respond_to do |format|
        if @portfolio.update(portfolio_params)
          current_user.add_role :editor, @portfolio
          format.html { redirect_to portfolios_path, notice: "Portfolio was successfully updated." }
          format.json { render :show, status: :ok, location: @portfolio }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @portfolio.errors, status: :unprocessable_entity }
        end
      end
  end

  def destroy
      @portfolio=Portfolio.find(params[:id])
      @portfolio.destroy
      respond_to do |format|
        format.html { redirect_to portfolios_path, notice: "Your Portfolio is successfully destroyed." }
        format.json { head :no_content }
      end
  end

  


  def show
      @portfolio=Portfolio.find(params[:id])
  end


  private

      def portfolio_params
          params.require(:portfolio).permit(:title, :subtitle, :body, technologies_attributes: [:name])
      end

end