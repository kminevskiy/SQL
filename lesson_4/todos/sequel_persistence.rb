require "sequel"

DB = Sequel.connect("postgres://localhost/todos")

class SequelPersistence
  def initialize(logger)
    DB.logger = logger
  end

  def find_list(id)
    all_lists.first(lists__id: id)
  end

  def all_lists
    DB[:lists].left_join(:todos, list_id: :id).
      select_all(:lists).
      select_append do
        [ count(todos__id).as(todos_count),
          count(nullif(todos__completed, true)).as(todos_remaining_count) ]
      end.
      group(:lists__id).
      order(:lists__name)
  end

  def create_new_list(list_name)
    DB[:lists].insert(name: list_name)
  end

  def update_list_name(list, new_name)
    DB[:lists].where(name: list[:name]).update(name: new_name)
  end

  def delete_list(id)
    DB[:todos].where(list_id: id).delete
    DB[:lists].where(id: id).delete
  end

  def add_new_todo(list, text)
    DB[:todos].insert([:list_id, :name], [list[:id], text])
  end

  def update_todo_status(id, list, new_status)
    DB[:todos].where([[list_id: list[:id]], [id: id]]).update(completed: new_status)
  end

  def delete_todo(id, list)
    DB[:todos].where([[list_id: list[:id]], [id: id]]).delete
  end

  def mark_all_todos_complete(list)
    DB[:todos].where(list_id: list[:id]).update(completed: true)
  end

  def find_todos(list_id)
    DB[:todos].where(list_id: list_id)
  end
end
