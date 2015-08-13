# == Schema Information
#
# Table name: nobels
#
#  yr          :integer
#  subject     :string
#  winner      :string

require_relative './sqlzoo.rb'

# BONUS PROBLEM: requires sub-queries or joins. Attempt this after completing
# sections 04 and 07.

def physics_no_chemistry
  # In which years was the Physics prize awarded, but no Chemistry prize?
  execute(<<-SQL)
    SELECT DISTINCT
      physics.yr
    FROM
      nobels AS physics
    INNER JOIN
      nobels AS no_chem ON physics.yr = no_chem.yr
    WHERE physics.subject = 'Physics'
    GROUP BY
      physics.yr
    HAVING
      SUM(CASE no_chem.subject
            WHEN 'Chemistry' THEN 1
          ELSE 0
          END) = 0
  SQL
end
