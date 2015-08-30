var Student = function(firstName, lastName) {
  this.firstName = firstName;
  this.lastName = lastName;
  this.courses = [];
};

Student.prototype.name = function() {
  return this.firstName + " " + this.lastName;
};

Student.prototype.enroll = function(course) {
  if (this.courses.indexOf(course) === -1) {
    console.log(this.conflictsWithEnrolledCourse(course));
    if (this.conflictsWithEnrolledCourse(course)) {
      throw (new Error("Scheduling conflict"));
      console.log("Error");
    }
    this.courses.push(course);
    course.students.push(this);
  }
};

Student.prototype.courseLoad = function() {
  var result = {};
  var department, i;

  for (i = 0; i < this.courses.length; i++ ) {
    department = this.courses[i].department;
    if ( !result[department] ) {
      result[department] = 0;
    }
    result[department] += this.courses[i].credits;
  }

  return result;
};

Student.prototype.conflictsWithEnrolledCourse = function(course) {
  for (courseIndex = 0; courseIndex < this.courses.length; courseIndex++) {
    if (this.courses[courseIndex].conflictsWith(course)) {
      return true;
    }
  }
  return false;
};

var Course = function(name, department, credits, block, days) {
  this.name = name;
  this.department = department;
  this.credits = credits;
  this.block = block;
  this.days = days;
  this.students = [];
};

Course.prototype.conflictsWith = function(otherCourse) {
  if (this.block === otherCourse.block) {
    for (var dayIndex = 0; dayIndex < this.days.length; dayIndex++) {
      if (otherCourse.days.indexOf(this.days[dayIndex]) !== -1) {
        return true;
      }
    };
  };

  return false;
};

Course.prototype.addStudent = function(student) {
  student.enroll(this);
};

jimmy = new Student('Jimmy', 'Brown');
basketWeaving = new Course("Basket Weaving (underwater)", "Art", 1, 2,["Mon","Tues","Wed"]);
fingerPainting = new Course("Finger Painting", "Art", 5, 3,["Mon"]);
advancedNeuropathy = new Course("Advanced Neuropathy", "Science", 6, 2, ["Tues","Thurs"]);

jimmy.enroll(basketWeaving);
console.log(jimmy.courseLoad());
basketWeaving.addStudent(jimmy);
console.log(jimmy.courseLoad());
fingerPainting.addStudent(jimmy);
console.log(jimmy.courseLoad());
advancedNeuropathy.addStudent(jimmy);

console.log(jimmy.courseLoad());
