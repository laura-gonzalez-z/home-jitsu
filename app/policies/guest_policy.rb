class GuestPolicy < ApplicationPolicy
  def create?
    true
  end

  def invite?
    true
  end

  def destroy?
    true
  end

  def accept?
    true
  end

  def reject?
    true
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
