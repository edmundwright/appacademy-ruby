require 'active_support/inflector'

class ModelBase
  def self.find_by_id(id)
    table_name = to_s.downcase.pluralize

    result = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        id = ?
    SQL

    new(result.first)
  end

  def self.all
    table_name = to_s.downcase.pluralize

    results = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        *
      FROM
        #{table_name}
    SQL

    results.map { |result| new(result) }
  end
end
