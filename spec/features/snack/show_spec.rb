require "rails_helper"

RSpec.describe "Snack show page", type: :feature do
  let!(:jeff) { Owner.create!(name: "Jeff") }

  let!(:colfax_machine) { Machine.create!(location: "Colfax", owner_id: jeff.id) }
  let!(:park_machine) { Machine.create!(location: "Park", owner_id: jeff.id) }

  let!(:ruffles) { Snack.create!(name: "Ruffles", price: 1.50) }
  let!(:oreos) { Snack.create!(name: "Oreos", price: 2.00) }
  let!(:chewy_bars) { Snack.create!(name: "Chewy Bars", price: 2.75) }

  let!(:machine_snack_1) { MachineSnack.create!(machine_id: colfax_machine.id, snack_id: ruffles.id) }
  let!(:machine_snack_2) { MachineSnack.create!(machine_id: colfax_machine.id, snack_id: ruffles.id) }
  let!(:machine_snack_3) { MachineSnack.create!(machine_id: colfax_machine.id, snack_id: oreos.id) }
  let!(:machine_snack_4) { MachineSnack.create!(machine_id: park_machine.id, snack_id: ruffles.id) }
  let!(:machine_snack_5) { MachineSnack.create!(machine_id: park_machine.id, snack_id: oreos.id) }
  let!(:machine_snack_6) { MachineSnack.create!(machine_id: park_machine.id, snack_id: chewy_bars.id) }

  it "lists snack info" do
    visit "/snacks/#{ruffles.id}"

    expect(page).to have_content(ruffles.name)
    expect(page).to have_content(ruffles.price)

    ruffles.machines.each do |machine|
      expect(page).to have_content(machine.location)
      expect(page).to have_content(machine.average_snack_price)
      expect(page).to have_content(machine.snack_kinds)
    end
  end
end
