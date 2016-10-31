object Hello extends App {
	// 1a
	println("Hello World")

	// 1b
	var generated: Array[Int] = Array()
	for (i <- 1 to 50) generated :+= i

	// 1c
	(51 to 100).map((x: Int) => generated :+= x)

	// 1d
	def sum_for_loop(input: Array[Int]): Int = {
		var sum: Int = 0
		for (i <- input) sum += i
		sum
	}
	println(sum_for_loop(generated))

	// 1e
	def sum_recursive(input: Array[Int]): Int = {
		if (input.isEmpty) {
			0
		} else {
			input{0} + sum_recursive(input.drop(1))
		}
	}
	println(sum_recursive(generated))

	// 1f
	def nth_fibonacci(n: BigInt): BigInt = {
		if (n == 0 || n == 1) {
			n
		} else {
			nth_fibonacci(n - 1) + nth_fibonacci(n - 2)
		}
	}
	(20 to 30).map((i) => println(nth_fibonacci(i)))

	// 2a
	def thread(f: () => Unit): Thread = {
		// This creates a thread by overriding a class method with another implementation. The thread is not yet started.
		new Thread {
			override def run {
				f()
			}
		}
	}

	// 2b
	// Note the return type being Array[() => Unit]. This means that we're returning an array of functions that return Unit.
	def fib_lambdas(n: BigInt): Array[() => Unit] = {
		if (n <= 0) {
			Array(() => println(nth_fibonacci(0)))
		} else {
			fib_lambdas(n - 1) ++ Array(() => println(nth_fibonacci(n)))
		}
	}

	// 2c
	val fibs = 33
	val threads = fib_lambdas(fibs).map((x) => thread(x))

	// 2d
	threads.map((x) => x.start)
	threads.map((x) => x.join)

	// Or more compactly
	fib_lambdas(fibs).map((x) => thread(x).start)
	// Or, if you use chaining
	fib_lambdas(fibs).map((x) => thread(x)).map((x) => x.start)

	// 3a
	def nonlazy_exec(f: () => BigInt, b: Boolean) = {
		val t = f()
		println("Inside nonlazy_exec")
		if (b) println(t)
	}
	nonlazy_exec(() => nth_fibonacci(35), false)

	// 3b
	def lazy_exec(f: () => BigInt, b: Boolean) = {
		lazy val t = f()
		println("Inside lazy_exec")
		if (b) println(t)
	}
	lazy_exec(() => nth_fibonacci(35), false)

	// 3c
	// In Oz, lazy is used for functions that will postpone computation until a decision needs to be made.
	// In Scala, a variable that is lazy will not be computed until it is required for another computation. It will always compute the value once and store the result in the lazy value. When the value is used again, that stored value is used.
}
