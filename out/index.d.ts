interface Connection {
	IsConnected(): boolean;
	Disconnect(): void;
}

interface Signal<C extends Callback = Callback> {
	Fire(...args: Parameters<C>): void;
	Connect(callback: (...args: Parameters<C>) => void): Connection;
	Wait(): LuaTuple<[...ReturnType<C>]>;
	DisconnectAll(): void;
}

interface SignalConstructor {
	new <C extends Callback = Callback>(): Signal<C>;
}

declare const Signal: SignalConstructor;
export = Signal;
