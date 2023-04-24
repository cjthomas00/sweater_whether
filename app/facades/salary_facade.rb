class SalaryFacade

  def self.get_salaries(destination)
    salaries = TeleportService.get_salaries(destination)
    salary = salaries[:salaries]
      Salary.new(salary)
    end
  end
end