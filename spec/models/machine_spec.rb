require "rails_helper"

RSpec.describe Machine, type: :model do
  describe "validations" do
    it { should validate_presence_of :location }
    it { should belong_to :owner }
    it { should have_many :machine_snacks }
    it { should have_many(:snacks).through(:machine_snacks) }
  end

  let!(:jeff) { Owner.create!(name: "Jeff") }
  let!(:colfax_machine) { Machine.create!(location: "Colfax", owner_id: jeff.id) }
  let!(:ruffles) { Snack.create!(name: "Ruffles", price: 2.0) }
  let!(:oreos) { Snack.create!(name: "Oreos", price: 2.0) }
  let!(:machine_snack_ruffles) { MachineSnack.create!(machine_id: colfax_machine.id, snack_id: ruffles.id) }
  let!(:machine_snack_oreos) { MachineSnack.create!(machine_id: colfax_machine.id, snack_id: oreos.id) }

  it "returns average price of snacks" do
    expect(colfax_machine.average_snack_price).to eq(2)
  end

  it "returns count of snack kinds" do
    expect(colfax_machine.snack_kinds).to eq(2)
  end
end
