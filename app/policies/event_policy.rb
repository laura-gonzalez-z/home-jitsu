class EventPolicy < ApplicationPolicy
  def show?
    true
  end

  def new?
    true
  end

  def create?
    true
  end

  def destroy?
    record.host_id == user.id
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
