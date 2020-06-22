import 'dart:async';
import 'package:Flutter_Bloc_Pattern/counter_event.dart';

class CounterBloc {
  int _counter = 0; //! mặc định counter để = 0
  final _counterStateController = StreamController<int>();
  StreamSink<int> get _inCounter => _counterStateController.sink;
  //! for state, exposing only a stream which outputs data
  Stream<int> get counter => _counterStateController.stream;

  final _counterEventController = StreamController<CounterEvent>();
  //! for event, exposing only a sink which is an input

  Sink<CounterEvent> get CounterEventSink => _counterEventController.sink;

  CounterBloc() {
    //! wherever there is a new event, we want to map it to a new state
    _counterEventController.stream.listen((event) {
      if (event is IncrementEvent)
        _counter++;
      else
        _counter--;
      _inCounter.add(_counter);
    });
  }
  void dispose(){
    _counterStateController.close();
    _counterEventController.close();
  }
}
