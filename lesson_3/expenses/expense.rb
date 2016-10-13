#!/usr/bin/env ruby
require "pg"
require "io/console"

class ExpenseData
  def initialize
    @connection = PG.connect(dbname: "expenses")
    setup_schema()
  end

  def add_expense(amount, memo, date = "NOW()")
    @connection.exec_params("INSERT INTO 
                            expenses (amount, memo, created_on)
                            VALUES ($1, $2, $3)", [amount, memo, date])
  end

  def list_expenses
    result = @connection.exec("SELECT * FROM expenses ORDER BY created_on ASC")
    display_expenses(result)
  end

  def search_expenses(string)
    result = @connection.exec_params("SELECT * FROM expenses WHERE memo ILIKE $1", ["%#{string}%"])
    display_expenses(result)
  end

  def delete_expense(id)
    result = @connection.exec_params("SELECT * FROM expenses WHERE id = $1", [id])
    if result.none?
      puts "There is no expense with the id '#{id}'"
    else
      puts "The following expense has been deleted:"
      display_expenses(result)
      @connection.exec_params("DELETE FROM expenses WHERE id = $1", [id])
    end
  end

  def clear_expenses
    puts "This will remove all expenses. Are you sure? (y/n)"
    input = STDIN.getch
    if input.casecmp("y") == 0
      @connection.exec("DELETE FROM expenses")
      puts "All expenses have been deleted."
    end
  end

  def setup_schema
    sql = "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'public' AND table_name = 'expenses'"
    new_table = "CREATE TABLE expenses (
    id serial PRIMARY KEY,
    amount numeric(6, 2) NOT NULL CHECK (amount >= 0.01),
    memo text NOT NULL,
    created_on date NOT NULL)"
    result = @connection.exec(sql)
    @connection.exec(new_table) if result.values.flatten.first == "0"
  end

  def display_expenses(result)
    if result.none?
      puts "There are no expenses."
    else
      puts "There are #{result.ntuples} expenses."
      result.each do |row|
        puts "#{row['id'].rjust(3)} | #{row['created_on']} | #{row['amount'].rjust(10)} | #{row['memo']}"
      end
      puts "-" * 45
      total = result.reduce(0) { |sum, row| sum + row['amount'].to_i }
      puts "Total #{total.to_s.rjust(24)}"
    end
  end

end

class CLI
  def initialize(arguments)
    @arguments = arguments
    @data = ExpenseData.new
  end

  def check_add_arguments()
    if @arguments.length < 3
      puts "You must provide an amount and memo"
    end
  end

  def check_arguments()
    add_args = @arguments[1..3]
    search_delete_arg = @arguments[1]
    case @arguments.first
    when "list" then @data.list_expenses()
    when "add"
      check_add_arguments()
      @data.add_expense(*add_args)
    when "search"
      @data.search_expenses(search_delete_arg)
    when "delete"
      @data.delete_expense(search_delete_arg)
    when "clear"
      @data.clear_expenses()
    else
      display_help()
    end
  end

  def display_help
    puts <<~HELP
    An expense recording system

    Commands:

    add AMOUNT MEMO [DATE] - record a new expense
    clear - delete all expenses
    list - list all expenses
    delete NUMBER - remove expense with id NUMBER
    search QUERY - list expenses with a matching memo field

    HELP
  end

  def run
    check_arguments()
  end
end

CLI.new(ARGV).run()
