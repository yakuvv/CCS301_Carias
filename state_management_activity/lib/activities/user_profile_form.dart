import 'package:flutter/material.dart';


 // STATE MANAGEMENT EXPLANATION:
 //   - This code uses StatefulWidget for state management.
 //   - State means data that can change over time and affects what the user sees on screen.
 //   - When state changes, it calls setState() to tell Flutter to rebuild the UI.
 //   - This makes the screen update with the new data.

class UserProfileForm extends StatefulWidget {
  const UserProfileForm({super.key});

  @override
  State<UserProfileForm> createState() => _UserProfileFormState();
}

class _UserProfileFormState extends State<UserProfileForm> {

// STATE VARIABLES:
//    - These variables hold the data that can change in our app.
//    - When these change, the UI updates to show the new values.

  // Controllers to get text from input fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  // Variables to store the user's profile information
  String displayName = '';
  int displayAge = 0;
  String displayEmail = '';

  // Variable to track if the form was successfully submitted
  bool isProfileSubmitted = false;

  // Variable to store error messages when validation fails
  String errorMessage = '';

 // ERROR HANDLING EXPLANATION:
 //     - I use try-catch blocks to handle errors gracefully.
 //     - This means when something goes wrong, the code doesn't crash.
 //     - Instead, i show a helpful error message to the user.
 //     - Validation checks make sure the user enters correct information:
 //         - Fields cannot be empty
 //         - Name must be at least 2 characters
 //         - Age must be a valid number between 1 and 120
 //         - Email must contain @ and .

  // This function validates input and submits the profile
  void submitProfile() {
    // setState() tells Flutter to rebuild the UI after we change state variables
    setState(() {
      try {
        // Clear any previous error messages
        errorMessage = '';

        // Get the text from each input field and remove extra spaces
        String name = nameController.text.trim();
        String ageText = ageController.text.trim();
        String email = emailController.text.trim();

        // ERROR HANDLING #1: Check for empty fields
        //  - If any field is empty, then it will throw an error
        if (name.isEmpty || ageText.isEmpty || email.isEmpty) {
          throw Exception('All fields are required!');
        }

        // ERROR HANDLING #2: Validate name length
        //  - Name must be at least 2 characters long
        if (name.length < 2) {
          throw Exception('Name must be at least 2 characters long!');
        }

        // ERROR HANDLING #3: Parse age number with try-catch
        //  - It will try to convert the age text to a number
        //  - If it fails (user typed letters), then it catches the error
        int age;
        try {
          age = int.parse(ageText);
        } catch (e) {
          throw Exception('Age must be a valid number!');
        }

        // ERROR HANDLING #4: Validate age range
        //  - The age must be between 1 and 120
        if (age < 1 || age > 120) {
          throw Exception('Age must be between 1 and 120!');
        }

        // ERROR HANDLING #5: Validate email format
        //  - The email must have @ and . to be valid
        if (!email.contains('@') || !email.contains('.')) {
          throw Exception('Please enter a valid email address!');
        }

         // STATE MANAGEMENT: Update state variables
         //  - If all validations pass, it updates the state variables with
        // the user's information

        displayName = name;
        displayAge = age;
        displayEmail = email;
        isProfileSubmitted = true;

        // Show success message to user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Profile submitted successfully!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );

      } catch (e) {

        // ERROR HANDLING: Catch any errors
        //    - If any validation fails, it will catch the error here
        //    - The code doesn't crash, instead it shows an error message rather

        errorMessage = e.toString().replaceAll('Exception: ', '');
        isProfileSubmitted = false;

        // Show error message to user in a red notification
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    });
    // After setState() finishes, flutter rebuilds the UI with the new data
  }

  // This function resets all fields back to empty
  void resetForm() {
    setState(() {
      // Clear all text fields
      nameController.clear();
      ageController.clear();
      emailController.clear();

      // Reset all state variables to their initial values
      displayName = '';
      displayAge = 0;
      displayEmail = '';
      isProfileSubmitted = false;
      errorMessage = '';
    });
  }

  @override
  void dispose() {
    // Clean up controllers when the widget is removed
    // This prevents memory leaks
    nameController.dispose();
    ageController.dispose();
    emailController.dispose();
    super.dispose();
  }

   // BUILD METHOD:
   //   - This method builds the UI (what the user sees)
   //   - Every time setState() is called, this method runs again
   // to rebuild the UI with the new state data
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Profile Form',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title
            Text(
              'Enter Your Information',
              style: TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
                height: 30),

            // Name input field
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Full Name',
                hintText: 'Enter your full name',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
                height: 20),

            // Age input field (only accepts numbers)
            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Age',
                hintText: 'Enter your age',
                prefixIcon: Icon(Icons.cake),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
                height: 20),

            // Email input field
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
                height: 30),

            // ERROR MESSAGE DISPLAY:
            //  - This box only appears when there is an error
            //  - It shows the error message in red

            if (errorMessage.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(8),
                ),

                child: Row(
                  children: [
                    Icon(Icons.error,
                        color: Colors.red),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        errorMessage,
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(
                height: 20),

            // Submit button that calls submitProfile() when clicked
            ElevatedButton(
              onPressed: submitProfile,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'SUBMIT PROFILE',
                style: TextStyle(fontSize: 15),
              ),
            ),
            SizedBox(
                height: 10),

            // Reset button that calls resetForm() when clicked
            OutlinedButton(
              onPressed: resetForm,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'RESET FORM',
                style: TextStyle(fontSize: 15),
              ),
            ),
            SizedBox(
                height: 30),

             //  PROFILE DISPLAY:
             //   - This card only appears when isProfileSubmitted is true
             //   - This is an example of state management - the UI changes
             // based on the value of our state variable

            if (isProfileSubmitted)
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.check_circle_sharp,
                        color: Colors.green,
                        size: 50,
                      ),
                      SizedBox(
                          height: 15),
                      Text(
                        'Profile Submitted!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      Divider(
                          height: 10),
                      // Display the user's information using state variables
                      ProfileInfoRow(
                        icon: Icons.person,
                        label: 'Name',
                        value: displayName,
                      ),
                      SizedBox(
                          height: 15),
                      ProfileInfoRow(
                        icon: Icons.cake,
                        label: 'Age',
                        value: '$displayAge years old',
                      ),
                      SizedBox(
                          height: 15),
                      ProfileInfoRow(
                        icon: Icons.email,
                        label: 'Email',
                        value: displayEmail,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// A custom widget to display each row of profile information
class ProfileInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const ProfileInfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue),
        SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}