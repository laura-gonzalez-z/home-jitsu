class PartnerPolicy < ApplicationPolicy
  def create?
    true
  end

  def destroy?
    true
  end

  def index?
    true
  end

  def accept?
    record.requestee_id == user.id
  end

  def reject?
    record.requestee_id == user.id
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
