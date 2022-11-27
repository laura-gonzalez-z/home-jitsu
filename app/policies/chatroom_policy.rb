class ChatroomPolicy < ApplicationPolicy
  def show?
    record.name.include? "_#{user.id}_"
  end

  def create?
    true
  end

  def my_messages?
    true
  end

  class Scope < Scope
    def resolve
      scope.where("name LIKE '%_#{user.id}_%'")
    end
  end
end
