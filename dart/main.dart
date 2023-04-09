class Creature {
	void live();
}

enum Team { red, blue }

class Player {
	final String name;
	int xp;
	Team team;
	int grade;
	Player({required this.name, required this.xp, required this.team, required this.grade,});
	void sayHello() {
		print('$name, $xp, $team, $grade');
	}
}

void main() {
	var player1 = Player(
		name: 'hwido',
		xp: 99,
		team: Team.red,
		grade: 100,
	);
	player1.sayHello();
}