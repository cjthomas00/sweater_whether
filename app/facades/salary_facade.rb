class SalaryFacade

  def self.get_salaries(destination)
    teleport_id = TeleportService.get_teleport_id(destination)
    ua_id = teleport_id[:ua_id]
    salaries = TeleportService.get_salaries(ua_id)
    salaries[:salaries].map do |salary|
      Salary.new(salary)
    end
  end
end