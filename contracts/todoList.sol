// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TodoList {
    struct Task {
        uint id;
        string content;
        bool completed;
    }

    // setiap user punya list task masing-masing
    mapping (address => Task[]) public userTasks;

    event TaskCreated(address user, uint id, string content);
    event TaskCompleted(address user, uint id);

    function createTask(string memory _content) public {
        uint taskId = userTasks[msg.sender].length;
        userTasks[msg.sender].push(Task(taskId, _content, false));

        emit TaskCreated(msg.sender, taskId, _content);
    }

    function toggleCompleted(uint _id) public {
        Task storage task = userTasks[msg.sender][_id];
        task.completed = !task.completed;

        emit TaskCompleted(msg.sender, _id);
    }

    function getTaskCount() public view returns (uint) {
        return userTasks[msg.sender].length;
    }

    function getAllTask() public view returns (Task[] memory) {
        return userTasks[msg.sender];
    }
}