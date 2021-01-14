local workshop = Fray.Config.Workshop
for _, id in pairs(workshop) do
	resource.AddWorkshop(id)
end