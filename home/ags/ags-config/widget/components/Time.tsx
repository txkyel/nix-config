import { Variable } from "astal";

const time = Variable("").poll(1000, "date");

const Time = () => (
  <button onClicked={() => print("hello")}>
    <label label={time()} />
  </button>
);

export default Time;
