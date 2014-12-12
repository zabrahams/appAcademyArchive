var Student = function(fname,lname) {
  this.fname = fname;
  this.lname = lname;
  this.courses = [];
}

Student.prototype.name = function (){
  return this.fname + " " + this.lname;
}

Student.prototype.enroll = function (course) {
  this.courses.push(course);
  course.students.push(this);
}

Student.prototype.courseLoad = function () {
  var course_load = {};
  var classes = this.courses;
  for (var i=0; i<classes.length; i++) {
    var dept = classes[i].department;
    if (course_load.hasOwnProperty(dept)) {
      course_load[dept] += classes[i].credits;
    }
    else {
      course_load[dept] = classes[i].credits;
    }
  };
  return course_load;
}


var Course = function(name,department,credits) {
  this.name = name;
  this.department = department;
  this.credits = credits;
  this.students = [];
}

Course.prototype.add_student = function (student) {
  student.enroll(this);
}
