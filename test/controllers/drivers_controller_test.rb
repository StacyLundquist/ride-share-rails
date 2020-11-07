require "test_helper"

describe DriversController do
  # Note: If any of these tests have names that conflict with either the requirements or your team's decisions, feel empowered to change the test names. For example, if a given test name says "responds with 404" but your team's decision is to respond with redirect, please change the test name.
  let (:new_driver) {
    Driver.new(name: "Kari", vin: "456789ABCDEFGH123", available: true)
  }
  before do
    Driver.create(name: "Kari",
                  vin: "123456789ABCDEFGH",
                  available: true)
  end

  let (:driver_hash) {
    {
      driver: {
        name: "Sisi",
        vin: "98765432112345678",
        available: false
      }
    }
  }
  describe "index" do
    it "responds with success when there are many drivers saved" do
      # Arrange
      # Ensure that there is at least one Driver saved
      new_driver.save
      # Act
      get drivers_path
      # Assert
      must_respond_with :success
    end

    it "responds with success when there are no drivers saved" do
      # Arrange
      # Ensure that there are zero drivers saved
      Driver.delete_all
      # Act
      get drivers_path
      # Assert
      must_respond_with :success
    end
  end

  describe "show" do
    it "responds with success when showing an existing valid driver" do
      # Arrange
      # Ensure that there is a driver saved
      new_driver = Driver.first

      # Act
      get driver_path(new_driver.id)

      # Assert
      must_respond_with :success
    end

    it "responds with 302 with an invalid driver id" do
      # Arrange
      # Ensure that there is an id that points to no driver
      # Act
      get driver_path(-1)
      # Assert
      must_respond_with :redirect
    end
  end

  describe "new" do
    it "responds with success" do
      # Act
      get new_driver_path

      # Assert
      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new driver with valid information accurately, and redirect" do
      # Arrange
      # Set up the form data

      # Act-Assert
      # Ensure that there is a change of 1 in Driver.count

      # Assert
      # Find the newly created Driver, and check that all its attributes match what was given in the form data
      # Check that the controller redirected the user

    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Set up the form data so that it violates Driver validations

      # Act-Assert
      # Ensure that there is no change in Driver.count

      # Assert
      # Check that the controller redirects

    end
  end

  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid driver" do
      # Arrange
      # Ensure there is an existing driver saved
      new_driver.save
      # Act
      get edit_driver_path(new_driver.id)
      # Assert
      must_respond_with :success
    end


    it "will respond with redirect when attempting to edit a nonexistant driver" do
      # Act
      get edit_trip_path(-1)

      # Assert
      must_respond_with :redirect
    end
    it "responds with redirect when getting the edit page for a non-existing driver" do
      # Arrange
      # Ensure there is an invalid id that points to no driver

      # Act

      # Assert

    end
  end

  describe "update" do
    it "can update an existing driver with valid information accurately, and redirect" do
      # Arrange
      # Ensure there is an existing driver saved
      # Assign the existing driver's id to a local variable
      # Set up the form data

      # Act-Assert
      # Ensure that there is no change in Driver.count

      # Assert
      # Use the local variable of an existing driver's id to find the driver again, and check that its attributes are updated
      # Check that the controller redirected the user
      driver = Driver.first
      expect {
        patch driver_path(driver.id), params: driver_hash
      }.wont_change "Driver.count"

      must_redirect_to root_path

      new_driver = Driver.find_by(name: driver_hash[:driver][:name])
      expect(new_driver.vin).must_equal driver_hash[:driver][:vin]
      expect(new_driver.available).must_equal driver_hash[:driver][:available]
    end

    it "does not update any driver if given an invalid id, and responds with a 302" do
      # Arrange
      # Ensure there is an invalid id that points to no driver
      # Set up the form data

      patch driver_path(-1)
      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        patch driver_path(-1)
      }.wont_change 'Driver.count'
      # Assert
      # Check that the controller gave back a 404


      # Assert
      must_respond_with :redirect
    end
  end

  it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
    # Note: This will not pass until ActiveRecord Validations lesson
    # Arrange
    # Ensure there is an existing driver saved
    # Assign the existing driver's id to a local variable
    # Set up the form data so that it violates Driver validations

    # Act-Assert
    # Ensure that there is no change in Driver.count

    # Assert
    # Check that the controller redirects

  end

  describe "destroy" do
    it "destroys the driver instance in db when driver exists, then redirects" do
      # Arrange
      # Ensure there is an existing driver saved
      driver = Driver.first

      # Act-Assert
      # Ensure that there is a change of -1 in Driver.count
      expect {
        delete driver_path(driver.id)
      }.must_differ 'Driver.count', -1

      # Check that the controller redirects
      must_redirect_to root_path

    end

    it "does not change the db when the driver does not exist, then redirects" do
      # Arrange
      # Ensure there is an invalid id that points to no driver

      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        delete driver_path(-1)
      }.wont_change 'Driver.count'

      # Assert
      # Check that the controller responds or redirects with whatever your group decides
      must_redirect_to drivers_path
    end
  end

end
