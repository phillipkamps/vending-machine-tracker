require "rails_helper"

RSpec.describe "Vending machine show page", type: :feature do
  let!(:jeff) { Owner.create!(name: "Jeff") }
  let!(:colfax_machine) { Machine.create!(location: "Colfax", owner_id: jeff.id) }
  let!(:ruffles) { Snack.create!(name: "Ruffles", price: 1.50) }
  let!(:oreos) { Snack.create!(name: "Oreos", price: 2.00) }
  let!(:machine_snack_ruffles) { MachineSnack.create!(machine_id: colfax_machine.id, snack_id: ruffles.id) }
  let!(:machine_snack_oreos) { MachineSnack.create!(machine_id: colfax_machine.id, snack_id: oreos.id) }

  it "lists all snack info for machine" do
    visit "/machines/#{colfax_machine.id}"

    colfax_machine.snacks.each do |snack|
      expect(page).to have_content(snack.name)
      expect(page).to have_content(snack.price)
    end
  end

  it "gets average price for all snacks in machine" do
    visit "/machines/#{colfax_machine.id}"
    expect(page).to have_content(colfax_machine.average_snack_price)
  end
end
