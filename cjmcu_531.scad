

// ширина всего корпуса
width = 12.6;
// толщина корпуса
height = 7.4;
// длина
length = 28.2;


// расстояние между осями крепежных дырок
dist = (23.1+16.7)/2;
// диаметр дырки на самом приборе
d = 3.1;





// ширина платы самого дальномера
las_w = 12.4;
// длина платы дальномера (без крепежных ушек)
las_l = 15.8;
// толщина платы (без пайки и самого дальномера)
las_h = 1.5;
// толщина компонент на нижней части платы
las_bot = 1.3;
// ширина уха крепления
las_pad_w = 5;

// длина самого блока лазера
las_m_l = 10;
// ширина блока лазера
las_m_w = 10;
//
las_m_h = 5;


eps=0.01;


module laser_pad() {
  translate([-las_pad_w/2,0,0]) cube([las_pad_w,las_pad_w/2,las_h]);
  translate([0,las_pad_w/2,0]) cylinder(d=las_pad_w,h=las_h);
  
  // прорезь для вставки самого уха в держатель
  translate([-las_w/2,0,0]) cube([las_w/2,las_pad_w,las_h]);
  
  // выбранная дырка под шуруп
  translate([0,las_pad_w/2,-5]) cylinder(d=1.5,h=12);
  
  translate([-8,-1,3.5]) cube([16,9,5]);
}

module laser1() {
  
  
  // основная пластина платы
  translate([-las_w/2,-las_l/2,0]) cube([las_w,las_l,las_h]);
  
  // правые и левые опоры ушек
  translate([0,las_l/2,0]) laser_pad();
  translate([0,-las_l/2,0]) mirror([0,1,0]) laser_pad();
  translate([-las_w/2,-las_l/2,-las_bot]) cube([las_w,las_l,las_bot]);

  // вырез под лазер
  las_m_r = 2;
  hull() {
  translate([-las_w/2,-las_m_l/2,las_h]) cube([las_m_w-2*las_m_r,las_m_l,las_m_h]);
  translate([las_m_r,-las_m_l/2+las_m_r,las_h]) cylinder(r=las_m_r,h=las_m_h,$fn=12);
  translate([las_m_r,las_m_l/2-las_m_r,las_h]) cylinder(r=las_m_r,h=las_m_h,$fn=12);
  }
  
  // вырез под провода
  hull() {
  translate([-las_w/2+1,-las_l/2+1,-3]) cylinder(h=3,d=2,$fn=12);
  translate([-las_w/2,-las_l/2,-3]) cube([1,1,3]);
  translate([-las_w/2+1,las_l/2-1,-3]) cylinder(h=3,d=2,$fn=12);
  translate([-las_w/2,las_l/2-1,-3]) cube([1,1,3]);
  }
}

module laser() {
  translate([las_w/2,0,las_bot]) laser1();
}


module holder1() {
  r=4;
  hull() {
  translate([0,-length/2+r,0]) cube([width,length-r*2,height]);
  translate([r,-length/2,0]) cube([r,r,height]);
  translate([r,length/2-r,0]) cube([r,r,height]);
  }
}


module holder() {
difference() {
holder1();
translate([-eps,0,1.2]) laser();
}

}

//laser();
//holder1();
rotate(v=[0,1,0],a=-90) holder();