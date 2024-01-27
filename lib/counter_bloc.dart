import 'dart:async';

enum CounterAction { Increment, Decrement, Rest }

class CounterBloc {
  int counter = 0;
  final _statStreamController = StreamController<int>();

  StreamSink<int> get counterSink => _statStreamController.sink;
  Stream<int> get counterStream => _statStreamController.stream;

  final _eventStreamController = StreamController<CounterAction>();

  StreamSink<CounterAction> get eventSink => _eventStreamController.sink;
  Stream<CounterAction> get eventStream => _eventStreamController.stream;

  CounterBloc() {
    eventStream.listen((event) {
      if (event == CounterAction.Increment) {
        counter++;
      } else if (event == CounterAction.Decrement) {
        counter--;
      } else if (event == CounterAction.Decrement) {
        counter = 0;
      }
      counterSink.add(counter);
    });
  }

  void dispose() {
    _statStreamController.close();
    _eventStreamController.close();
  }
}
