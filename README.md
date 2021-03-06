### Github Link: 
  https://github.com/nehakerkar/ClassPortal

### Deployment Link: 
  https://wolfpackportal.herokuapp.com

### SuperAdmin Login details: 
```
email: superadmin@ncsu.edu 
password: test123
```

### Assumptions: 
* A course can be created without an instructor. Hence,
if you try to search for a course which does not have any instructor
assigned, your search will not show the course.

* System only has super admin pre configured. Instructor can be added to the system by the admins. Students may sign up from login page.

* If course enddate < currentdate, it won't show in search neither will it be enroll-able.

### Instructions
  * In order to add an instructor to a course, you first need to create a course template which contains the title, coursenumber and description for the course. You may then create the course with instructor. You may add multiple instructors for the same course but with different start/end times (non colliding).

  ```
    Steps:
    *Manage Courses --> Create New Generic Course Template --> Create Course*
    *Manage courses --> Create New Courses --> Create Course Instructor*
  ```

  *  Similarly, If you have to delete a course, you first need to delete all course-instructor mappings, then course-student mappings, then course-materials and then delete the course template.

  ```
  Steps:
    *Manage Students --> View/Edit/Remove Students from courses --> Destroy (all relevant records)*
    *Manage Courses --> View/Edit/Delete Courses --> Destroy (all relevant records)*
    *Manage material --> Add Material to Courses --> Destroy (all relevant records)*
    *Manage courses --> View/Edit/Remove Generic Course Templates --> Destroy*
  ```

  * Admin approving a student request for a course:
  ```
  Steps:
    *Manage Students --> View/Edit/Remove Students from courses --> Edit --> Change the status from dropdown.*
  ```
  
  * Steps for an instructor to request to make his course inactive: (Instructor can request only for courses where he is instructing)
  ```
  Steps:
    *Home Page --> Request to make course inactive --> Click on the relevant button to make the request.*
  ```
