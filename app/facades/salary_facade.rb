class SalaryFacade

  def self.get_salaries(destination)
    salaries = TeleportService.get_salaries(destination)
    salaries[:salaries].map do |salary|
      Salary.new(salary)
    end
  end
end