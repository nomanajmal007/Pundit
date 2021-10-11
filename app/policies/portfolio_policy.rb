class PortfolioPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if @user.has_role? :admin
      scope.all
      else
        scope.where(body: "")
      end
    end

  end

  def index?
    true
    #false Then no one can access
  end



end
